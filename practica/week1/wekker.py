
import time

# Define a counter
seconds = 5

# As long as counter is not zero:
while seconds > 0:

    print("Tick")

    # Decrement counter
    seconds = seconds - 1

    # Sleep for one second
    time.sleep(1)

# Make beep sound
print("BEEEEEP")
print('\a')