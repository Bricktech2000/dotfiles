import os
import sys


def search(root_path, accronym):
  if len(accronym) == 0:
    return [root_path]

  candidate_paths = []
  (_, directories, _) = next(os.walk(root_path))

  for directory in directories:
    for i, (dir_char, acc_char) in enumerate(zip(directory, accronym)):
      if dir_char.lower() != acc_char.lower():
        break

      candidate_paths += search(os.path.join(root_path, directory), accronym[i+1:])

  return candidate_paths


if len(sys.argv) == 1:
  print('.')

elif len(sys.argv) == 2:
  candidate_paths = search('.', sys.argv[1]) or ['.']
  most_recent_path = max(candidate_paths, key=os.path.getmtime)
  print(most_recent_path)

else:
  print('Usage: .hd.py [<accronym>]')
  sys.exit(1)
