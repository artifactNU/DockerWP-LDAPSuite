#!/bin/bash

# Check if the CSV file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

csv_file=$1
output_file="ldif_output.ldif"

# Create the 'users' OU
echo "dn: ou=users,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: users" > "$output_file"

# Read each line from the CSV file and create LDIF entries
while IFS=, read -r first_name last_name; do
    # Generate LDIF entry for each user
    ldif_entry=$(cat <<EOF
dn: cn=${first_name} ${last_name},ou=users,dc=example,dc=com
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: ${first_name} ${last_name}
sn: ${last_name}
givenName: ${first_name}
mail: ${first_name}.${last_name}@example.com
userPassword: password
uid: ${first_name}.${last_name}
EOF
    )
    echo "" >> "$output_file"  # Add an empty line for readability
    echo "$ldif_entry" >> "$output_file"
done < "$csv_file"

ldapadd -x -c -D "cn=admin,dc=example,dc=com" -w password -f ldif_output.ldif # Replace with the admin password
