import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider

def ctf_function(z, x):
    """
    Computes the CTF for a given defocus value z and spatial frequency x.

    Args:
        z (float): Defocus value (angstrom)
        x (float): Spatial frequency (angstrom^-1)

    Returns:
        float: The CTF value for the given defocus and spatial frequency.
    """
    return np.sin(- np.pi * z * x**2 + np.pi / 2 * x ** 4)

# Generate a 2D meshgrid of size 100,100 and calculate the CTF values
z_init = 0
x = np.linspace(-2, 2, 500)
y = np.linspace(-2, 2, 500)
X, Y = np.meshgrid(x, y)
r = np.sqrt(X**2 + Y**2)
ctf = ctf_function(z_init, r)

# Create the plot
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))
plt.subplots_adjust(left=0.1, bottom=0.25)  # Adjust for sliders

# 2D CTF plot
im = ax1.imshow(ctf, cmap='gray')
ax1.set_title("Contrast Transfer Function (2D)")
ax1.set_xlabel("Spatial Frequency (1/angstrom)")
ax1.set_ylabel("Spatial Frequency (1/angstrom)")

# 1D CTF plot
positive_x = x[x >= 0]
ctf_1d = ctf_function(z_init, positive_x)
line, = ax2.plot(positive_x, ctf_1d, lw=2)
ax2.set_title("Contrast Transfer Function (1D)")
ax2.set_xlabel("Spatial Frequency (1/angstrom)")
ax2.set_ylabel("CTF Value")

# Add sliders
ax_z = plt.axes([0.1, 0.1, 0.65, 0.03])
slider_z = Slider(ax_z, 'z', -2, 2, valinit=z_init)

# Update function for sliders
def update(val):
    z = slider_z.val
    ctf = ctf_function(z, r)
    im.set_data(ctf)  # Update the 2D image
    line.set_ydata(ctf_function(z, positive_x))  # Update the 1D plot
    fig.canvas.draw_idle()

slider_z.on_changed(update)
plt.show()
