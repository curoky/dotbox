#!/usr/bin/env python3
# Copyright 2021 curoky(cccuroky@gmail.com).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
'''
Usage:
$ fpath | zsh-analyze-fpath.py
'''

from copy import deepcopy
import sys
from pathlib import Path
from typing import Dict, List
from rich.console import Console
from rich.table import Table
from collections import defaultdict

import typer

app = typer.Typer(add_completion=True, help='')


@app.command()
def analyze():
    lines: List[str] = sys.stdin.readlines()
    if not lines:
        raise typer.Abort('read null from stdin!')
    tablePathCount = Table()
    tablePathCount.add_column('Path', justify='left', style='cyan', no_wrap=True)
    tablePathCount.add_column('Count', style='magenta')
    tableNameDup = Table()
    tableNameDup.add_column('Name', justify='left', style='cyan', no_wrap=True)
    tableNameDup.add_column('Path', style='magenta')

    name2path: Dict[str, List[str]] = defaultdict(list)
    for p in set(map(lambda l: l.strip(), lines)):
        count = 0
        for f in Path(p).glob('_*'):
            count += 1
            if f.name == '_ninja':
                print(p)
            name2path[f.name].append(p)
        if count:
            tablePathCount.add_row(p, str(count))

    for name, paths in name2path.items():
        if len(paths) != 1:
            for p in paths:
                tableNameDup.add_row(name, deepcopy(p))

    console = Console()
    console.print(tablePathCount)
    console.print(tableNameDup)


if __name__ == '__main__':
    app()
