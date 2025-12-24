While you **can** use HTTPS, MLflow does not support it natively. To run it over HTTPS, you must put a "shield" in front of it called a **Reverse Proxy** (usually Nginx).

Without a reverse proxy, you can only use `http://`. However, if your goal is just to access it securely from your local Windows PC without setting up complex web servers, here are your three best options:

---

### Option 1: The "Lazy" Way (Direct Access via Security Groups)

If you don't want to deal with SSL certificates, you can keep using `http://`, but restrict access so **only your computer** can see it.

1. In the **AWS EC2 Console**, edit your **Inbound Rules**.
2. Change the Source from `0.0.0.0/0` to **"My IP"**.
3. Access it via `http://<EC2-IP>:5000`. Your browser will say "Not Secure," but it will work, and no one else on the internet can access your data.

---

### Option 2: The "Proper" Way (HTTPS with Nginx)

If you specifically need the URL to start with `https://`, you must install Nginx on your Ubuntu server to handle the encryption.

**Step 1: Install Nginx**

```bash
sudo apt update && sudo apt install nginx -y

```

**Step 2: Create a Self-Signed Certificate**

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/mlflow.key \
-out /etc/ssl/certs/mlflow.crt \
-subj "/C=US/ST=State/L=City/O=MLOps/OU=MLflow/CN=localhost"

```

**Step 3: Configure Nginx to forward traffic**
Create a file at `/etc/nginx/sites-available/mlflow`:

```nginx
server {
    listen 443 ssl;
    server_name _;

    ssl_certificate /etc/ssl/certs/mlflow.crt;
    ssl_certificate_key /etc/ssl/private/mlflow.key;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
    }
}

```

*After saving, link it: `sudo ln -s /etc/nginx/sites-available/mlflow /etc/nginx/sites-enabled/` and restart: `sudo systemctl restart nginx`.*

---

### Option 3: The "Pro" Way (SSH Tunneling)

This is the **most secure** and doesn't require opening any ports (5000) on AWS at all. It makes your computer think MLflow is running locally.

1. On your **Windows PC**, open PowerShell and run:
```powershell
ssh -i "your-key.pem" -L 5000:localhost:5000 ubuntu@<EC2-IP>

```


2. Keep that terminal open.
3. On your EC2, run MLflow normally: `mlflow ui --port 5000`.
4. On your Windows browser, go to: **`http://localhost:5000`**.

---

### Summary Table

| Method | Protocol | Effort | Security |
| --- | --- | --- | --- |
| **Inbound Rule** | HTTP | Very Low | Low (IP restricted) |
| **Nginx Proxy** | HTTPS | High | High (Encrypted) |
| **SSH Tunnel** | HTTP (Internal) | Medium | **Highest** (No ports open) |

