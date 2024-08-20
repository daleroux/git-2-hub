
# Git-2-Hub

This repository contains a script and configuration file to automate the process of cloning an Ansible co
llection from a Git repository, building it, and publishing it to an Private Automation Hub. This README 
will guide you through parametrizing the `ansible.cfg` file and using the `git-2-hub.sh`

## Prerequisites

- **Ansible**: Ensure Ansible is installed on the system where you will run the script.
- **Access to a Private Automation Hub**: You need access to a Private Automation Hub / custom Private Automation Hub with appropriate permissions and a valid API token.
- **Namespace exists**: Make sure the namespace of your collection exists in your Private Automation Hub, if not then create it.

## Parametrizing the `ansible.cfg` File

The `ansible.cfg` file is used to configure the Ansible environment, particularly the settings for interacting with a Private Automation Hub. You can parameterize this configuration to use different servers or tokens.

### Template `ansible.cfg` File

Below is the template for the `ansible.cfg` file:

```ini
[galaxy]
server_list = my_repo

[galaxy_server.my_repo]
url={{ server_url }}
token={{ server_token }}
```

### Parameters

- **`server_url`**: The URL of the Private Automation Hub.
- **`server_token`**: The API token for authentication with the Private Automation Hub.

### Creating a Parameterized `ansible.cfg`

1. **Copy the Template**: Use the above template as your `ansible.cfg` file.
2. **Replace Parameters**: Replace `{{ server_url }}` with the actual URL of your Private Automation Hub and `{{ server_token }}` with your API token.

Alternatively, you can use environment variables or dynamically generate this configuration file within your script if needed.

Make sure the namespace of your collection exists in your Private Automation Hub, if not then create it.

## Using the `git-2-hub.sh` Script

The provided script automates the process of building and publishing an Ansible collection. The script now takes only one argument, which is the full Git repository URL. It addresses the following RFE: [RFE] ability to sync/upload collections from a Git Repo to the Private Automation Hub.

### Script Overview

The `git-2-hub.sh` script performs the following steps:

1. **Clones the Git repository** from the specified URL.
2. **Changes directory** to the cloned repository.
3. **Builds the Ansible collection** using `ansible-galaxy collection build`.
4. **Copies the `ansible.cfg` file** to the repository directory.
5. **Publishes the Ansible collection** to the configured Private Automation Hub.
6. **Cleans up** by deleting the cloned repository.

### Script Parameters

The script now takes a single parameter:

- **`FULL_GIT_REPO_URL`**: The full URL of the Git repository, including the base URL and repository name.

### How to Run the Script

1. **Ensure the `ansible.cfg` file is properly configured** with your Private Automation Hub details as described above.
2. **Run the script** with the appropriate parameters:

   ```bash
   ./git-2-hub.sh <full URL of the Git repository>
   ```

   - Example:

     ```bash
     ./git-2-hub.sh https://github.com/daleroux/ansible-collection-hello_tam_blog
     ```

### Example Usage

```bash
./git-2-hub.sh https://github.com/daleroux/ansible-collection-hello_tam_blog
```

This command will clone the repository from `https://github.com/daleroux/ansible-collection-hello_tam_blog`, build the Ansible collection, and publish it to the Private Automation Hub specified in the `ansible.cfg` file.

## Cleaning Up

After the script completes its execution, it removes the cloned repository directory to keep your workspace clean. If you want to retain the repository directory for any reason, you can modify or comment out the cleanup step in the script.

---
