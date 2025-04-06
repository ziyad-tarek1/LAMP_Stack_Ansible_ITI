# LAMP Stack Automation with Ansible - ITI Final Project

![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![Amazon AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

Automated deployment of a LAMP stack (Linux, Apache, MariaDB, PHP) with WordPress on Amazon Linux 2023 EC2 instances.

![Ansible-project](https://github.com/user-attachments/assets/3976cffc-0de3-4fdf-915d-ec94abf8fa8c)


## 📌 Overview
This Ansible project automates the complete setup and configuration of a WordPress website on AWS EC2 instances. It is developed as the final project for Ansible Course at the Information Technology Institute (ITI) System Admin training.


## ✨ Features
- Full LAMP stack installation
- Automated WordPress deployment
- Secure MariaDB configuration
- Automatic system updates
- PHP 8.2 with essential modules
- Proper file permissions management
- Database creation and user setup

## 📋 Prerequisites
- Ansible 2.9+
- Amazon Linux 2023 EC2 instance
- SSH access to target machine
- Inventory file configured with EC2 instance details


## 📂 Project Structure

```bash
.
├── LICENSE                         # Project license 
├── README.md                      # project overview and usage instructions
│
├── wordpress-bashscript           # Bash script for setting up a LAMP stack and WordPress
│   └── LAMP.sh                    # Installs Apache, MariaDB, PHP, and WordPress manually via bash
│
├── wordpress-manualsetup          #  Guide for manual installation of WordPress
│   └── README.md                  # Instructions for installing and configuring WordPress manually
│
├── wordpress-playbook             #  Ansible playbook for automating WordPress deployment
│
│   ├── inventory.ini              # Inventory file with host definitions 
│   ├── playbook.yml               # Main Ansible playbook that includes all roles
│
│   └── roles                      #  Ansible roles for modular configuration
│       ├── apache/                # Role for installing and configuring Apache web server
│       │   └── tasks/
│       │       └── main.yml      # Apache installation and configuration tasks
│
│       ├── mariadb/              # Role for installing and configuring MariaDB (MySQL-compatible)
│       │   ├── defaults/
│       │   │   └── main.yml      # Default variables for MariaDB 
│       │   ├── tasks/
│       │   │   └── main.yml      # Tasks for installing and securing MariaDB
│       │   └── vars/
│       │       └── main.yml      # Static variables for MariaDB
│
│       ├── php/                  # Role for installing PHP and modules
│       │   └── tasks/
│       │       └── main.yml      # PHP installation tasks
│
│       ├── update/               # Role to update system packages
│       │   └── tasks/
│       │       └── main.yml      # System update commands using `yum` or `apt`
│
│       └── wordpress/            # Role for downloading and configuring WordPress
│           ├── README.md         # Role-specific notes and usage
│           ├── defaults/
│           │   └── main.yml      # Default variables (e.g., WordPress version, paths)
│           ├── handlers/
│           │   └── main.yml      # Handlers (e.g., restart Apache if configs change)
│           ├── meta/
│           │   └── main.yml      # Metadata about the role (dependencies, etc.)
│           ├── tasks/
│           │   └── main.yml      # WordPress download, extract, permissions, config
│           └── vars/
│               └── main.yml      # Static variables like database name, user, etc.

```

### 📂 File Descriptions:
- **LAMP.sh**: Bash script implementation of the LAMP stack setup (alternative to Ansible)
- **inventory.ini**: Contains target EC2 instance connection details
- **playbook.yml**: Orchestrates role execution and playbook flow
- **roles/wordpress/tasks/main.yml**: Defines core installation tasks:
  - System updates
  - Package installation (Apache, MariaDB, PHP)
  - Service management
  - Database configuration
  - WordPress deployment
- **roles/wordpress/handlers/main.yml**: Manages Apache service restarts
- **roles/wordpress/defaults/main.yml**: Contains default variables for customization
- **roles/wordpress/vars/main.yml**: For environment-specific variable overrides


# 📘 Documentation Used  

## AWS Documentation  
- [EC2 LAMP on Amazon Linux 2023](https://docs.aws.amazon.com/linux/al2023/ug/ec2-lamp-amazon-linux-2023.html)  
- [EC2 LAMP on Amazon Linux 2](https://docs.aws.amazon.com/linux/al2/ug/ec2-lamp-amazon-linux-2.html#prepare-lamp-server)  
## Ansible Documentation  

- **Package Management:**  
  - [`ansible.builtin.yum`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/yum_module.html)  
  - [`ansible.builtin.dnf`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/dnf_module.html)  

- **Service Management:**  
  - [`ansible.builtin.systemd_service`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_service_module.html)  

- **Command Execution:**  
  - [`ansible.builtin.command`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/command_module.html)  
  - [`ansible.builtin.shell`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/shell_module.html)  

- **File and Configuration Management:**  
  - [`ansible.builtin.file`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)  
  - [`ansible.builtin.lineinfile`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html)  

- **File Operations:**  
  - [`ansible.builtin.copy`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)  
  - [`ansible.builtin.unarchive`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/unarchive_module.html)  
  - [`ansible.builtin.get_url`](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)  

- **Playbook and Role Reusability:**  
  - [Reusing Playbooks with Roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)  

## Installation
1. Clone the repository:
```bash
git clone https://github.com/ziyad-tarek1/LAMP_Stack_Ansible_ITI.git
cd LAMP_Stack_Ansible_ITI
```

2. Configure inventory file (`inventory.ini`):
```ini
[wordpress]
wordpress_instence1 ansible_host=<your-ec2-public-ip> ansible_user=ec2-user
```

3. Create `vars/main.yml` with your configuration:
```yaml
document_root: /var/www/html
db_root_password: your_secure_root_password
wp_db_name: wordpress
wp_db_user: wpuser
wp_db_password: StrongPassword!
```

4. Run the playbook:
```bash
ansible-playbook -i inventory.ini playbook.yml
```
## ✅ Deployment Output  

### 📜 Playbook Execution Output  
After running the playbook, you should see output similar to this:  

![Playbook Execution Output](https://github.com/user-attachments/assets/c4c795b7-2035-4165-bd6c-dcdb381b7175)  

---

## 🎨 WordPress Interface  

### 🔐 WordPress Login Page  
![WordPress Login Page](https://github.com/user-attachments/assets/e2d62494-e606-4dc5-8287-10f466c36fcf)  

### 🏠 WordPress Main Page  
![WordPress Main Page](https://github.com/user-attachments/assets/6c90b9b8-541f-41b2-8a21-d4b7b0cea723)  


## ⚙️ Configuration
The playbook handles the following automatic configurations:
- System package updates
- Apache & MariaDB installation
- PHP 8.2 with required modules
- WordPress core installation
- Database setup and permissions
- Secure MariaDB configuration
- Proper file ownership and permissions

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork** the repository
2. Create a feature branch:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Follow existing coding style and patterns
4. Test your changes thoroughly
5. Submit a **Pull Request** with clear description of changes
6. Ensure Ansible playbook runs successfully in clean environment

**Development Standards:**
- Maintain idempotence in all Ansible tasks
- Use explicit state declarations in YAML files
- Keep variables in appropriate scopes (defaults vs vars)
- Include comments for complex task logic
- Update documentation (README) with any changes


## 👨‍💻 Authors
- **Ziyad Tarek**  
  [![GitHub](https://img.shields.io/badge/GitHub-ziyad--tarek1-blue)](https://github.com/ziyad-tarek1)  
  [![Email](https://img.shields.io/badge/Email-ziyadtarek180%40gmail.com-red)](mailto:ziyadtarek180@gmail.com)

- **Omar Ahmed**  
  [![GitHub](https://img.shields.io/badge/GitHub-omarahmed-blue)](https://github.com/OmarEltabakh123)  
  [![Email](https://img.shields.io/badge/Email-omarahmed%40gmail.com-red)](mailto:Omar.ahmed.attia123@gmail.com)

- **Amer Hatem**  
  [![GitHub](https://img.shields.io/badge/GitHub-amrhatem-blue)](https://github.com/moraa121212)  
  [![Email](https://img.shields.io/badge/Email-amrhatem%40gmail.com-red)](mailto:amr.hatem2h@gmail.com)

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.







