pipeline {
	agent any
	tools {
		terraform 'Terraform_1.9'
	}
	environment {
		DIST_PATH = "app/dist/"
		ANSIBLE_ROLE_PATH = "ansible/roles/nestjs/files"
		
	}
	stages {
		stage('Clonado Repositorio') {
			steps {
				checkout scm
			}
		}
		stage('Dependencias, Test y Compilacion') {
			steps {
					sh '''
					npm install
					npm run test
					npm run build
					'''
			}
			post {
				success {
					echo "Compilación y test correctos"
				}
				failure {
					error("Falla dependencial o TEST")
				}
			}
		}
		stage('Copiar el DIST al rol de Ansible') {
			steps {
				sh """
				cp -r ${DIST_PATH} ${ANSIBLE_ROLE_PATH}/
				ls -lh ${ANSIBLE_ROLE_PATH}
				"""
			}
		}
		stage('Terraform validate') {
			steps {
				withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'aws-credentials'
                                ], file(credentialsId: 'credencial-pem', variable: 'AWS_KEY_FILE')]) {
                                        sh '''
                                        terraform init
					terraform validate
                                        terraform plan -var="ruta_private_key=${AWS_KEY_FILE}" -out=tfplan
                                        terraform apply -auto-approve tfplan
                                        '''
				}
			}
		}
		stage('Deploy con Ansible') {
			steps {
				sh """
				ansible-playbook -i inventory main.yml
				"""
			}
		}
		stage('Terraform Destroy') {
			steps {
				input message: "Deseas destruir la infraestructura?"
				withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'aws-credentials'
                                ], file(credentialsId: 'credencial-pem', variable: 'AWS_KEY_FILE')]) {
					sh """
					terraform destroy -auto-approve -var="ruta_private_key=${AWS_KEY_FILE}"
					"""
				}
			}
		}
	}
	post {
		success {
			echo "Pipeline completado correctamente."
		}
		failure {
			echo "Error en el pipeline."
		}
	}
}
