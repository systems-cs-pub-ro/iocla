#!/usr/bin/env python3

# Note:
#
# In order to run install:
#   1. pandoc   (sudo apt-get install pandoc).
#   2. dokuwiki (pip install dokuwiki)
#   3. pypandoc (pip install pypandoc)

import dokuwiki
import pypandoc
import argparse
import re

tags = {
    'NOTE'      : '<note> ',
    'TIP'       : '<note tip> ',
    'IMPORTANT' : '<note important> ',
    'INFO'      : '<note info> ',
    'WARNING'   : '<note warning> ',
}

lab_to_namespace_suffix = {
    'laborator/content/reprezentare-numere'       : 'laborator-01',
    'laborator/content/operatii-memorie-gdb'      : 'laborator-02',
    'laborator/content/toolchain-decompilare'     : 'laborator-03',
    'laborator/content/introducere-asamblare'     : 'laborator-04',
    'laborator/content/rolul-registrelor-adresare': 'laborator-05',
    'laborator/content/stiva'                     : 'laborator-06',
    'laborator/content/apel-functii'              : 'laborator-07',
    'laborator/content/structuri-vectori-siruri'  : 'laborator-08',
    'laborator/content/interactiune-c-assembly'   : 'laborator-09',
    'laborator/content/buffer-overflow'           : 'laborator-10',
    'laborator/content/optimizari'                : 'laborator-11',
    'laborator/content/linking'                   : 'laborator-12',
}

regexes = {}
note_beg_regex = re.compile("^\s*>\s*")
for tag, _ in tags.items():
    regexes[tag] = re.compile("^\s*>\s*[*_]{2,3}\s*" + tag + "\s*:?\s*[*_]{2,3}\s*:?\s*")

NAMESPACE     = 'iocla/laboratoare/'
ENDNOTE       = ' </note>'

parser = argparse.ArgumentParser(description='md to ocw format')
parser.add_argument('-o', '--output', help='output')
parser.add_argument('-u', '--username', help='user')
parser.add_argument('-p', '--password', help='password')
parser.add_argument(
    '-f',
    '--files',
    nargs='+',
    help='markdown files to publish, all files should be named README.md')


def create_connection(username, password):
    return dokuwiki.DokuWiki('https://ocw.cs.pub.ro/courses',
                             username,
                             password,
                             cookieAuth=True)

def convert_notes(content):
    content = content.split('\n')
    n = len(content)

    in_form_prev = False
    for i in range(n):
        in_form_curr = False
        if note_beg_regex.match(content[i]):
            found_tag = False
            in_form_curr = True
            for tag, regex in regexes.items():
                if regex.match(content[i]):
                    found_tag = True
                    content[i] = regex.sub(tags[tag], content[i])
                    break
                    
            if not found_tag:
                content[i] = note_beg_regex.sub('', content[i])
            
        if not in_form_curr and in_form_prev:
            content[i-1] = content[i-1] + ENDNOTE
        
        in_form_prev = in_form_curr
    
    if in_form_prev:
        content[n-1] = content[n-1] + ENDNOTE
    
    return '\n'.join(content)
        

def update_pages(conn, page, content):
    try:
        conn.pages.set(NAMESPACE + page, content)
    except (dokuwiki.DokuWikiError, Exception) as err:
        # ocw doesn't send always valid reply
        if not str(err).startswith(
                'XML or text declaration not at start of entity'):
            print('unable to process: %s' % err)


def main():
    args = vars(parser.parse_args())
    if args['username'] is not None and args['password'] is not None and args['files'] is not None:
        conn = create_connection(args['username'], args['password'])
        files = args['files']
        for file in files:
            output = convert_notes(pypandoc.convert_file(file, 'dokuwiki', format='gfm', extra_args=['--wrap=preserve']))
            namespace_suffix = lab_to_namespace_suffix[file.replace('/README.md', '')]
            update_pages(conn, namespace_suffix, output)
    elif args['files'] is not None and len(args['files']) == 1:
        if args['output'] is not None:
            fout = args['output']
        else:
            fout = 'README.doku'
        output = convert_notes(pypandoc.convert_file(args['files'][0], 'dokuwiki', format='gfm', extra_args=['--wrap=preserve']))
        with open(fout, 'w') as f:
            f.write(output)
    else:
        print('invalid combination of arguments')


if __name__ == '__main__':
    main()
