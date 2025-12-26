# Arch Linux Setup

Este repositório existe para permitir a **reconstrução consciente e reproduzível** de um ambiente Arch Linux previamente lapidado. Não se trata apenas de instalar pacotes, mas de restaurar uma configuração coerente de sistema, shell e aplicações.

O objetivo é que, partindo de uma instalação mínima do Arch Linux, seja possível retornar a um ambiente funcional, padronizado e previsível com o menor número possível de decisões improvisadas.

---

## Filosofia do projeto

* Automatizar o que é repetitivo
* Declarar explicitamente tudo o que é essencial
* Evitar dependência de estados ocultos
* Manter o processo simples o suficiente para ser auditável

---

## Estrutura do repositório

```
arch-setup/
├── install.sh
├── packages.txt
├── aur-packages.txt
├── config/
│   ├── fish/
│   ├── nvim/
│   ├── ghostty/
│   ├── niri/
│   └── ...
└── README.md
```

### install.sh

Script principal de orquestração. Ele executa, em ordem:

1. Atualização do sistema
2. Instalação de pacotes oficiais (pacman)
3. Instalação do helper AUR (yay), se ausente
4. Instalação de pacotes do AUR
5. Aplicação das configurações do diretório `config/`

O script **não deve ser executado como root**.

---

### packages.txt

Lista de pacotes instalados explicitamente a partir dos repositórios oficiais do Arch.

Gerado com:

```
pacman -Qqe > packages.txt
```

Este arquivo representa aquilo que o sistema considera essencial por escolha direta do usuário.

---

### aur-packages.txt

Lista de pacotes provenientes do AUR (ou pacotes locais).

Gerado com:

```
pacman -Qqm > aur-packages.txt
```

Antes de reutilizar este arquivo em outra máquina, recomenda-se revisar seu conteúdo.

---

### config/

Contém as configurações de usuário, espelhando a estrutura de `~/.config` pessoal do usuario do repositorio.

Durante a execução do script, este diretório é sincronizado para:

```
~/.config/
```

Cada subdiretório representa a configuração de uma aplicação específica.

---

## Padronização do shell para Fish

Este projeto assume o **Fish Shell** como shell padrão do usuário.

### 1. Instalação

O Fish deve estar listado em `packages.txt`. Caso não esteja, adicione:

```
fish
```

---

### 2. Definir Fish como shell padrão

Após a execução do `install.sh`, execute manualmente:

```
chsh -s /usr/bin/fish
```

Este comando altera o shell padrão do usuário atual.

> Observação: a mudança só terá efeito após logout ou reinício da sessão.

---

### 3. Estrutura de configuração do Fish

As configurações do Fish devem residir em:

```
config/fish/
```

Estrutura típica:

```
config/fish/
├── config.fish
├── functions/
└── conf.d/
```

Esses arquivos serão aplicados automaticamente durante a sincronização do diretório `config/`.

---

## Execução do processo completo

Em um Arch Linux recém-instalado:

1. Instalar dependências mínimas:

```
sudo pacman -S git base-devel
```

2. Clonar o repositório:

```
git clone https://github.com/PedroAOC20/arch-setup.git
cd arch-setup
```

3. Tornar o script executável:

```
chmod +x install.sh
```

4. Executar:

```
./install.sh
```

5. Reiniciar o sistema ou sessão

---

## O que este projeto não faz

* Não particiona discos
* Não configura bootloader
* Não gerencia usuários
* Não decide por você quais pacotes são necessários

Essas decisões pertencem ao momento da instalação base do Arch.

---

## Manutenção do repositório

Sempre que o ambiente for alterado de forma significativa:

```
pacman -Qqe > packages.txt
pacman -Qqm > aur-packages.txt
```

E então versionar as mudanças.

---

## Consideração final

Ele permite retornar a um estado conhecido, mas a responsabilidade pelas escolhas permanece sempre com quem executa o script.
