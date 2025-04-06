# WordPress Installation on Amazon Linux 2023 (EC2)

This guide covers installing **WordPress** on an **Amazon Linux 2023 (AL2023) EC2 instance**, including **Apache (httpd), MariaDB, and PHP 8.2**.

---

## **Step 1: Connect to Your EC2 Instance**
Use SSH to connect to your EC2 instance:
```bash
ssh -i your-key.pem ec2-user@your-ec2-public-ip
```
Replace `your-key.pem` with your private key file and `your-ec2-public-ip` with your instance’s public IP address.

---

## **Step 2: Update System Packages**
```bash
sudo yum update -y
```

---

## **Step 3: Install Apache (HTTPD)**
```bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```


---

## **Step 4: Install MariaDB (MySQL)**
```bash
sudo yum install -y mariadb105-server
```
Start and enable MariaDB:
```bash
sudo systemctl start mariadb
sudo systemctl enable mariadb
```
Secure the MariaDB installation:
```bash
sudo mysql_secure_installation
```
Follow the prompts:
- Press **Enter** (no password by default)
- Set a **new root password** (optional)
- Answer **Yes (Y)** to all security prompts.

---

## **Step 5: Create WordPress Database and User**
Run the following command to create the **database, user, and grant privileges**:
```bash
sudo mysql -u root -e "CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'StrongPassword!';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;"
```
Replace `'StrongPassword!'` with a secure password.

Verify database creation:
```bash
sudo mysql -u root -e "SHOW DATABASES;"
```
Ensure `wordpress` appears in the output.

---

## **Step 6: Install PHP 8.2 and Required Modules**
Amazon Linux 2023 does not support `amazon-linux-extras`, so install PHP 8.2 using DNF:
```bash
sudo dnf install php8.2 -y

sudo dnf install php-mysqlnd php-fpm php-json php-mbstring php-xml php-cli php-gd php-curl -y

```
Restart Apache:
```bash
sudo systemctl restart httpd
```

---

## **Step 7: Download and Configure WordPress**
Change to the web root directory:
```bash
cd /var/www/html
```
Download WordPress:
```bash
sudo curl -O https://wordpress.org/latest.tar.gz
```
Extract it:
```bash
sudo tar -xzf latest.tar.gz
```
Move files to the web root:
```bash
sudo mv wordpress/* .
sudo rm -rf wordpress latest.tar.gz
```
Set correct permissions:
```bash
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## **Step 8: Configure WordPress Database Connection**
Copy the sample configuration file:
```bash
sudo cp wp-config-sample.php wp-config.php
```
Edit database settings automatically:
```bash
sudo sed -i "s/database_name_here/wordpress/;
s/username_here/wpuser/;
s/password_here/StrongPassword!/;" /var/www/html/wp-config.php
```
Ensure `'StrongPassword!'` matches the password set in **Step 5**.

---

## **Step 9: Restart Services**
```bash
sudo systemctl restart httpd
sudo systemctl restart mariadb
```

---

## **Step 10: Access WordPress in a Web Browser**
Find your EC2 instance’s **Public IP Address** in the AWS Console.

Open your browser and go to:
```
http://your-ec2-public-ip
```
You should see the **WordPress setup wizard**. Follow the instructions to complete the installation.

---

🎉 **Congratulations! WordPress is now installed on your Amazon Linux 2023 EC2 instance.** 🚀

---

## **Author**
- **GitHub**: [ziyad-tarek1](https://github.com/ziyad-tarek1)
- **Email**: [ziyadtarek180@gmail.com](mailto:ziyadtarek180@gmail.com)

Happy developing! 😊
