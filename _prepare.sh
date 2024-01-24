#!/bin/bash

echo "Downloading archive with stadiu and ordins..."
wget -q --show-progress -O stadiu-ordins.tar.gz "https://www.dropbox.com/scl/fi/njfwduqbj4z46fvfd5nno/stadiu-ordins.tar.gz?rlkey=zyg2wquot52tkz6cvtb7lyl9p&dl=1"
echo "Unpacking documents..."
tar zxf stadiu-ordins.tar.gz
echo "Creating database and tables..."
sqlite3 data.db '.read create_tables.sql'
echo "Completed!"
echo ""
echo "To get new stadiu EDIT and paste correct url mask for stadiu files"
echo "in file update-pub.sh then run this script"
echo ""
echo "To parse all stadiu in directory stadiu/pub/ run ./parse_stadiu.py"
echo ""
echo "To get new ordins run ./get_ordins.py"
echo "To parse ordins run ./parse_ordins.py"
echo ""
