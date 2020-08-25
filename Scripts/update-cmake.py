#!/bin/env python3

import sys
import os
from os import path
from string import Template
from glob import glob

template_dir = sys.argv[1]
original_dir = os.getcwd()
os.chdir(template_dir)
templates = glob("**/CMakeLists.txt", recursive=True)
os.chdir(original_dir)
exclusions = ["LinuxMain.swift"]
for template_path in templates:
    template_path_dir = path.join(path.dirname(template_path))
    glob_pattern = path.join(template_path_dir, "**", "*.swift")
    sources = [path.relpath(p, template_path_dir) for p in glob(glob_pattern, recursive=True)]
    sources = [p for p in sources if not p in exclusions]
    sources = [f'"{p}"' for p in sources if not p in exclusions]
    sources.sort()
    source_list_text = "\n  ".join(sources)

    with open(path.join(template_dir, template_path)) as template_file:
        template_text = template_file.read()
        template_text = template_text.replace('$source_list', source_list_text)
        with open(template_path, 'w') as target_file:
            target_file.write(template_text)

