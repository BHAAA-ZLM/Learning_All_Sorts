import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from skimage import io, color, transform

# CTF function
def ctf_function(z, x):
    """
    Computes the CTF for a given defocus value z and spatial frequency x.

    Args:
        z (float): Defocus value (angstrom).
        x (float): Spatial frequency (angstrom^-1).

    Returns:
        float: The CTF value for the given defocus and spatial frequency.
    """
    return np.sin(-np.pi * z * x**2 + (np.pi / 2) * x**4)

# Load the image
ori_image = io.imread('/Users/lumizhang/Documents/GitHub/Learning_All_Sorts/transmission_EM/escherichia-coli-bacterium.tif')  # Replace with your image path
if len(ori_image.shape) == 3:  
    ori_image = color.rgb2gray(ori_image)  

image = transform.resize(ori_image, (500, 500), anti_aliasing=True)

def ctf_transform(image, z = 1):
    # Fourier Transform
    f_transform = np.fft.fft2(image)
    f_transform_shifted = np.fft.fftshift(f_transform)

    # Generate the CTF
    z_init = z
    rows, cols = image.shape
    x = np.linspace(-2, 2, cols)
    y = np.linspace(-2, 2, rows)
    X, Y = np.meshgrid(x, y)
    r = np.sqrt(X**2 + Y**2)
    ctf = ctf_function(z_init, r)
    filtered_transform = f_transform_shifted * ctf  # Apply CTF

    # Inverse Fourier Transform
    filtered_transform_shifted = np.fft.ifftshift(filtered_transform)
    filtered_image = np.fft.ifft2(filtered_transform_shifted)
    filtered_image = np.abs(filtered_image)
    return ctf, filtered_transform, filtered_image

output = ctf_transform(image)

# Create the plot
fig, ax = plt.subplots(1, 4, figsize=(12, 6))
plt.subplots_adjust(left=0.1, bottom=0.25)  # Adjust for sliders

# Original image
ax[0].imshow(image, cmap='gray')
ax[0].set_title("Original Image")
ax[0].axis('off')

# 2D CTF plot
ctf_im = ax[1].imshow(output[0], cmap='gray')
ax[1].set_title("Contrast Transfer Function (2D)")
ax[1].set_xlabel("Spatial Frequency (1/angstrom)")
ax[1].axis('off')

# Filtered image
filtered_im = ax[2].imshow(np.log(np.abs(output[1]) + 1), cmap='gray')
ax[2].set_title("Image After CTF Filtering")
ax[2].axis('off')

# Output image
out_im = ax[3].imshow(1 + output[2], cmap='gray', vmin=0, vmax=output[2].max() + 1)
ax[3].set_title("Filtered Image")
ax[3].axis('off')

# Add sliders
ax_z = plt.axes([0.1, 0.1, 0.65, 0.03])
slider_z = Slider(ax_z, 'z', -2, 2, valinit=1)

# Update function for sliders
def update(val):
    z = slider_z.val
    output = ctf_transform(image, z)
    ctf_im.set_data(output[0])
    filtered_im.set_data(np.log(np.abs(output[1]) + 1))
    out_im.set_data(1 + output[2])
    fig.canvas.draw_idle()

slider_z.on_changed(update)
plt.show()
