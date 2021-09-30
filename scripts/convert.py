#!/usr/bin/env python3

# DEPENDENCIES:
#
# 1. pandoc   (sudo apt-get install pandoc).
# 2. dokuwiki (pip install dokuwiki)
# 3. pypandoc (pip install pypandoc)
#
# IMPORTANT:
# 
# In order to upload to ocw directly 

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

regexes = {}
note_beg_regex = re.compile("^\s*>\s*")
for tag, _ in tags.items():
    regexes[tag] = re.compile("^\s*>\s*[*_]{2,3}\s*" + tag + "\s*:?\s*[*_]{2,3}\s*:?\s*")

NAMESPACE = 'iocla/laboratoare/'
ENDNOTE   = ' </note>'

parser = argparse.ArgumentParser(description='converts a markdown file to wiki format')
parser.add_argument('-u', '--username',  help='username for ocw account (e.g. gigel)')
parser.add_argument('-p', '--password',  help='password for ocw account (e.g. secret)')
parser.add_argument('-n', '--namespace', help='provide the namespace that needs to be updated (e.g laborator-01, laborator-02, ...)')
parser.add_argument('-f', '--file',      help='markdown files to publish, all files should be named README.md', required=True)


def create_connection(username, password):
    return dokuwiki.DokuWiki('https://ocw.cs.pub.ro/courses', username, password, cookieAuth=True)

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
        if not str(err).startswith('XML or text declaration not at start of entity'):
            print('unable to process: %s' % err)


def main():
    args = vars(parser.parse_args())

    if args['username'] is not None and args['password'] is not None and args['namespace'] is not None:
        # If username, password and namespace are provided upload in ocw
        conn   = create_connection(args['username'], args['password'])
        output = convert_notes(pypandoc.convert_file(args['file'], 'dokuwiki', format='gfm', extra_args=['--wrap=preserve']))
        update_pages(conn, args['namespace'], output)
    else:
        # Otherwise convert the file to wiki format
        output = convert_notes(pypandoc.convert_file(args['file'], 'dokuwiki', format='gfm', extra_args=['--wrap=preserve']))
        with open('README.doku', 'w') as f:
            f.write(output)

if __name__ == '__main__':
    main()
