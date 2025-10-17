#!/bin/bash
# Actualizar sistema
apt update -y && apt upgrade -y

# Instalar el agente de SSM
snap install amazon-ssm-agent --classic
systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
