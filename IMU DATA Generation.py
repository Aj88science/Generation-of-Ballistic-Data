import numpy as np
import matplotlib.pyplot as plt

# Define the number of data points and the time step
num_samples = 1000
time_step = 0.01  # 10 ms

# Define initial roll, yaw, and pitch values in radians
initial_roll = 0.0
initial_yaw = 0.0
initial_pitch = 0.0

# Create arrays to store the generated data
roll_values = np.zeros(num_samples)
yaw_values = np.zeros(num_samples)
pitch_values = np.zeros(num_samples)

# Create noise parameters (adjust as needed)
roll_noise_stddev = 0.1
yaw_noise_stddev = 0.1
pitch_noise_stddev = 0.1

# Generate synthetic IMU data
for i in range(num_samples):
    # Simulate noise
    roll_noise = np.random.normal(0, roll_noise_stddev)
    yaw_noise = np.random.normal(0, yaw_noise_stddev)
    pitch_noise = np.random.normal(0, pitch_noise_stddev)

    # Update roll, yaw, and pitch with noise
    roll = initial_roll + roll_noise
    yaw = initial_yaw + yaw_noise
    pitch = initial_pitch + pitch_noise

    # Store the values
    roll_values[i] = roll
    yaw_values[i] = yaw
    pitch_values[i] = pitch

    # Update initial values for the next iteration (e.g., to simulate motion)
    initial_roll = roll
    initial_yaw = yaw
    initial_pitch = pitch

# Create time values
time_values = np.arange(0, num_samples * time_step, time_step)

# Plot the roll, yaw, and pitch data
plt.figure(figsize=(12, 6))
plt.subplot(3, 1, 1)
plt.plot(time_values, roll_values, label='Roll (rad)')
plt.title('IMU Roll')
plt.grid(True)
plt.legend()

#plt.subplot(3, 1, 2)
#plt.plot(time_values, yaw_values, label='Yaw (rad)')
#plt.title('IMU Yaw')
#plt.grid(True)
#plt.legend()

#plt.subplot(3, 1, 3)
#plt.plot(time_values, pitch_values, label='Pitch (rad)')
#plt.title('IMU Pitch')
#plt.xlabel('Time (s)')
#plt.grid(True)
#plt.legend()

plt.tight_layout()
plt.show()
