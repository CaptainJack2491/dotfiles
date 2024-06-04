import subprocess

def get_ping():
  """Pings the server and returns the round-trip time in milliseconds."""
  # Replace "your_server_address" with your actual server address
  ping_process = subprocess.Popen(["ping", "-c 1", "google.com"], stdout=subprocess.PIPE)
  output, _ = ping_process.communicate()
  
  # Parse the output to find the average time
  for line in output.decode("utf-8").splitlines():
    if "time=" in line:
      # Extract the time value (assuming format "time=XX.Y ms")
      ping_time = float(line.split("=")[3].split()[0])
      return ping_time  # Convert to integer for display
  
  # If ping fails, return a placeholder value
  return -1

ping_value = get_ping()

if ping_value > 0:
  output_string = f"{ping_value}ms"
else:
  output_string = "Unreachable"

print(output_string)

