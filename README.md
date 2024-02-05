# DockerWP-LDAPSuite

## Introduction
This project integrates OpenLDAP, WordPress, and MySQL with phpLDAPadmin and Adminer, facilitating their deployment as Docker containers. Utilizing Docker Compose and Makefile, it streamlines the setup, deployment, backup, and restoration processes, making it ideal for development and testing environments.

## Background
Originally conceived as a school project by a team of five members, DockerWP-LDAPSuite has evolved from its beginnings in a private repository to a publicly available tool designed for broader use. Initially developed to meet specific educational objectives, this project has been extended to serve as a versatile resource for those interested in exploring the integration of OpenLDAP, WordPress, and MySQL with phpLDAPadmin and Adminer within Docker environments.

The DockerWP-LDAPSuite is now structured around `example.com`, featuring fictive test users, to facilitate a generic setup ideal for lab environments and educational purposes. Whether you're a student, educator, or tech enthusiast, this repository offers a comprehensive platform for learning, experimentation, and demonstration of containerized application management and LDAP integration.

This open-source extension aims to provide a hands-on learning experience, showcasing the practical application of Docker and LDAP in managing web services and user authentication. It's perfectly suited for labbing, tutorials, and developing a deeper understanding of how these technologies interact in a controlled, scalable environment.

We invite contributions, feedback, and queries from all users to further enrich this learning tool and foster a community of knowledge-sharing and innovation.

### Acknowledgments

This project owes its inception to the hard work and innovation of its original contributors, developed as part of a school project in a private repository. We extend our sincerest gratitude to the team members for laying the foundation upon which DockerWP-LDAPSuite is built.

#### Original Contributors

- https://github.com/marcus-yh/  - Recognized for their contributions to Docker and Makefile configurations.
- https://github.com/tromoe      - Valued for their overall project management and coordination.
- https://github.com/sollejr     - Acknowledged for their work on WordPress, phpLDAPadmin and MySQL setup.
- https://github.com/Adamesd     - Appreciated for their insights into backups and cronjobs.

Their collective effort has been instrumental in the development of this project, serving as a cornerstone for further exploration and learning in the realms of Docker, LDAP, and web services integration.

For more information on the original project or to explore further contributions from these individuals, please visit their respective GitHub profiles linked above.


## Prerequisites

### System Requirements

#### For Docker Host:
- Linux OS: Ensure your system is running a compatible Linux distribution, as this project is not tested on Windows or macOS environments.
- make: A utility for directing compilation. It's crucial for running the setup and deployment scripts.
- git: Required for cloning the project repository.
- Docker version 25.0.2: It's critical to use this version or newer, but avoid Docker Desktop, especially on Windows or macOS, to ensure compatibility and performance. Docker Desktop is not recommended for this project.

#### For Backup Server:
- Linux OS with SSH daemon enabled and running.
- Port 22 must be open for SSH access.
- Ensure the user running the Docker host is also added to the Backup server for seamless operation.

## Installation and Setup

### Before You Begin
Ensure all prerequisites are met. If Docker is not installed, follow the official Docker documentation to install Docker version 25.0.2 or newer, remembering to avoid Docker Desktop. Install `make` and `git` using your Linux distribution's package manager.

### Setting Up the Environment
1. Clone the project repository:
   ```bash
   git clone git@github.com:artifactNU/DockerWP-LDAPSuite.git
   ```
2. Navigate to the project directory:
   ```bash
   cd DockerWP-LDAPSuite
   ```
3. Run the setup script to prepare your environment. This includes configuring SSH keys for the backup server, installing cron jobs for scheduled backups, and setting the admin password for secure access:
   ```bash
   make setup
   ```

## Makefile Targets

### Deployment
- `make deploy`: Initializes and starts all required Docker containers in detached mode.
- `make stop`: Stops all running containers and removes them.

### Building Custom Images
- `make build-wordpress`: Builds a custom WordPress Docker image.
- `make build-alpine`: Builds a custom Alpine Docker image for utilities such as backups.
- `make build`: Builds all custom Docker images specified in the Docker Compose file.

### Backup and Restoration
- `make backup`: Backup the content of all Docker volumes locally.
- `make backup-and-rsync`: Synchronizes local backups to a configured backup server.
- `make restore-from-backup BACKUP_DATE=<backup timestamp>`: Restores Docker volumes from a specified backup. Use the timestamp of the desired backup in the format `YYYYMMDD_HHMMSS`.

### System Maintenance
- `make docker-reset`: Removes all Docker containers, images, volumes, and performs a system prune to free up space.
- `make install-cron-jobs`: Installs scheduled cron jobs for automated backups.
- `make configure-ssh`: Configures SSH for secure communication with the backup server.
- `make set-admin-password`: Sets a secure admin password for accessing the deployed applications.

## Generating LDAP Users

The repository includes a script for generating LDAP users from a CSV file and adding them to the OpenLDAP server. This script creates LDIF entries for each user specified in the CSV and imports them into the LDAP directory. After running the script, the users will be available for authentication and authorization in the LDAP server.

### Prerequisites

Before running the script, ensure you have:
- A CSV file with user information formatted as `firstname,lastname`. No header should be present in the file. A sample file is provided in the `src/ldap` directory.
- Access to the running `DWLS-openldap` container.

### Steps to Generate LDAP Users

1. **Prepare Your CSV File**: Create a CSV file containing the users you wish to add. Each line should represent a user with their first and last name separated by a comma, like so:
John,Doe
Jane,Smith

2. **Access the LDAP Container**: Use `docker exec` to access the running LDAP container with a Bash shell:
```bash
docker exec -it DWLS-openldap bash
./ldifscript.sh testnames.csv
```


## Troubleshooting
For common issues and troubleshooting tips, please see TROUBLESHOOTING.md

## Contributing
We welcome contributions! Please see CONTRIBUTING.md

## License
This project is released under the MIT License. See the LICENSE file in the project repository for full license text.

## Support/Contact
For support, please open an issue in the GitHub repository. For other inquiries contact simon@artifact.nu
