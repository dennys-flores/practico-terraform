# practico-terraform
Trabajo Practico terraform y ansible

Este repositorio contiene una aplicación en NestJs, infraestructura con Terraform, automatización con Ansible y pipeline con Jenkins.


## Ejecutar la aplicación NestJs

### Instalar dependencias

```bash
cd app
npm install 
```

### Ejecutar la app

```bash
npm run start
```

---

### Ejecutar tests

```bash
npm run test
```

---

##  Desplegar infraestructura con Terraform

### Inicializar Terraform

```bash
cd terraform
terraform init
```

### Validar configuración

```bash
terraform validate
```

### Ver plan de ejecución

```bash
terraform plan
```

### Aplicar cambios

```bash
terraform apply
```

### Destruir infraestructura

```bash
terraform destroy
```

---

## ⚙️ 4. Configuración con Ansible

### Ejecutar playbook

```bash
cd ansible
ansible-playbook -i inventory playbook.yml
```

---

## Pipeline con Jenkins

El archivo `Jenkinsfile` define el pipeline CI/CD.

### Ejecutar en Jenkins:

1. Se creo un nuevo pipeline en Jenkins
2. Conecta este repositorio
3. Jenkins detectará automáticamente el `Jenkinsfile`

