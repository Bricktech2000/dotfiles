import os
import sys


def search(root_path, accronym):
  dirs = next(os.walk(root_path))[1]
  possible_paths = []

  if len(accronym) == 0:
    possible_paths += [root_path]

  for dir in dirs:
    for i, (dir_char, acc_char) in enumerate(zip(dir, accronym)):
      if dir_char.lower() != acc_char.lower():
        break

      possible_paths += search(os.path.join(root_path, dir), accronym[i + 1:])

  return possible_paths


if len(sys.argv) == 1:
  print('.')

elif len(sys.argv) == 2:
  possible_paths = search('.', sys.argv[1]) or ['.']
  most_recent_path = max(possible_paths, key=os.path.getmtime)
  print(most_recent_path)

else:
  print('Usage: .ch.py [<accronym>]')
  sys.exit(1)
