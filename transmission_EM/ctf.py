import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider

# The Contrast transfer function (generalized for all TEMs)
# From 3D electron microscopy of macromolecular assemblies, J. Frank, 2006
def ctf_function(z, x):
    """
    Computes the CTF for a given defocus value z and spatial frequency x.

    Args:
        z (float): Defocus value (angstrom)
        x (float): Spatial frequency (angstrom^-1)

    Returns:
        float: The CTF value for the given defocus and spatial frequency.
    """

    # l = 0.0037 # Wavelength of the electron beam (nm)
    # C_s = 1 # Spherical aberration coefficient (mm) for HRTEM
    return np.sin(- np.pi * z * x**2 + np.pi / 2 * x ** 4)

# Generate x, z values
# x's Upper limit set to 2 = 1/ 0.5 which is a quite good resolution.
x = np.linspace(0, 2, 5000)
z_init = 0

# Create the plot
fig, ax = plt.subplots()
plt.subplots_adjust(left=0.1, bottom=0.25)  # Adjust for sliders
line, = ax.plot(x, ctf_function(z_init, x), lw=2)
ax.set_title("Interactive Contrast Transfer Function")
ax.set_xlabel("Frequency (1/angstrom)")
ax.set_ylabel("")

# Add sliders
ax_z = plt.axes([0.1, 0.1, 0.65, 0.03]) 
slider_z = Slider(ax_z, 'z', -2, 2, valinit=z_init)

# Update function for sliders
def update(val):
    z = slider_z.val
    line.set_ydata(ctf_function(z, x))  # Update the line
    fig.canvas.draw_idle()

# Connect sliders to update function
slider_z.on_changed(update)
plt.show()
