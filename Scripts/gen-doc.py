#!/usr/bin/env python3

import json
import sys

class Doc:
    def __init__(self, desc: str, params: list[tuple[str, str, list[str]]], ret: tuple[str, str]):
        self.desc = desc
        self.params = params
        self.ret = ret

    def formatted(self) -> str:
        maxName = max([0] + [len(n[0]) for n in self.params])
        maxType = max([0] + [len(n[1]) for n in self.params])
        maxText = max([0] + [sum(len(l) for l in p[2]) + 4 * (len(p[2]) - 1) for p in self.params])
        result: [str] = [
            '```swift',
            'let a = 1',
            '```',
            '\n',
            self.desc,
            '\n',
        ]

        if self.params:
            result.append('**Parameters**\n')
            result.append('| ' + ' ' * maxName + ' | ' + ' ' * (maxType + 2) + ' | ' + ' ' * maxText + ' |')
            result.append('| ' + '-' * maxName + ' | ' + '-' * (maxType + 2) + ' | ' + '-' * maxText + ' |')
            for name, ptype, desc in self.params:
                result.append('| ' + name.ljust(maxName) + ' | `' + ptype.ljust(maxType) + '` | ' + ('<br>'.join(desc)).ljust(maxText) + ' |')

        if self.ret:
            result.append("")
            result.append("**Returns**")
            result.append('| ' + ' ' * (len(self.ret[0]) + 2) + ' | ' + ' ' * len(self.ret[1]) + ' |')
            result.append('| ' + '-' * (len(self.ret[0]) + 2) + ' | ' + '-' * len(self.ret[1]) + ' |')
            result.append('| `' + self.ret[0] + '` | ' + self.ret[1] + ' |')
        return '\n'.join(result)

if __name__ == '__main__':
    for documented in json.loads(sys.stdin.read()):
        documentable = documented['documentable']
        doc = documented['docstring']
        params = []
        for (param, paramDoc) in zip(documentable['details']['parameters'], doc['parameters']):
            params.append(
                (
                    param['name'],
                    param['type'].strip(),
                    [l['text'] for l in paramDoc['description']],
                )
            )
        returnType = documentable['details'].get('returnType', None)
        docReturn = doc.get('returns', None)
        if returnType and docReturn:
            returnDoc = (returnType, '\n'.join([l['text'] for l in docReturn['description']]))
        else:
            returnDoc = None
        doc = Doc(
            '\n'.join(l['text'] for l in doc['description']),
            params,
            returnDoc
        )

        print('\n', documentable['path'])
        print(documentable['name'])
        print(doc.formatted())
