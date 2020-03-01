"""Prints a '{key} = {value}' formatted string for each item
in os.environ

"""
from __future__ import print_function

import os


def main():
    keyList = sorted(os.environ.keys())
    for key in keyList:
        print('{} = {}\n'.format(key, os.environ.get(key)))


if __name__ == '__main__':
    main()
    