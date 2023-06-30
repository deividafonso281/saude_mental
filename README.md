# Saúde mental

Projeto da disciplina MC426 no primeiro semestre de 2023. O grupo constituído pelos menbros presentes na próxima sessão tem o intuito de construir uma aplicação que facilite o contato de profissionais da saúde mental com seus pacientes.

# Membros da equipe

Beatriz Iamauchi Barroso - RA: 166531
Bruno Sobreira França - RA: 217787
Lannah Pimenta Pardo - RA: 248372
Susane Amabila Freires dos Santos - RA: 193978

# Descrição da Arquitetura do projeto

Breve descrição textual do estilo arquitetural do projeto, contendo informações dos príncipais componentes e serviços utilizados, além uma de uma explicação sucinta dos estilos arquiteturais adotados.

## Diagrama C4

![Diaagrama C4](https://github.com/deividafonso281/saude_mental/blob/main/images/diagramac4/Diagrama%20C4.jpg)

## Estilos adotados na elaboração da arquitetura

Foi Adotado o estilo de arquitetura em camadas, onde existe uma camada de serviços, que fornece uma série de componentes (api firestore, api de autenticação, api de localização) , cujo a camada de páginas (Página de agenda, Página de agendamento e etc..) faz acesso. Além disso, também identificamos o estilo do publish subscribe para o funcionamento do sistema de agendamento do app, que é atualizado conforme os dados que estão presentes no banco de dados, então quando esses mudam as agendas dos usúarios, devem mudar.

## Componenentes da aplicação Flutter

Componentes embarcados nos dispisitivos móveis, escritos com uso do framework Flutter.

### Páginas

Componentes responsáveis por prover o que o usúario visualiza ao utilizar a aplicação:

- Página de agenda: Este componente tem como responsabilidade de ser para os usuários (pacientes e profissionais) um sistema de gerenciamento dos agendamentos realizados por ele. 

- Página de agendamento: Este componente tem como responsabilidade viabilizar o agendamento de algum serviço de saúde ao usuário paciente.

- Página de busca: Este componente tem como responsabilidade oferecer ao usuário paciente uma seção que lhe permita realizar uma busca com alguns pré filtros.

- Página de cadastro: Este componente tem como responsabilidade viabilizar o cadastro dos usuários (pacientes e profissionais) na plataforma.

- Página de informações do profissional: Este componente tem como responsabilidade fornecer uma lista de serviço de saúde ao paciente, na qual, ele pode aplicar filtros para especificar especificar sua busca.

- Página de login: Este componente tem como responsabilidade fornecer aos usuários (pacientes e profissionais) um serviço de login

- Página principal: Este componente tem como responsabilidade fornecer aos usuários um home page, com atalhos para as funcionalidades do applicativo

- Página do usuário: Este componente tem como responsabilidade servir como um sistema de gerenciamento para os usuários (pacientes e profissionais)

### Componentes que fornecem acesso as APIs

Compoentes responsaveis por prover a camada de página serviços métodos para acesso a serviços externos:

- Api de dados: componente responsável por prover às páginas acesso aos dados, que estão no banco de dados. O componente então é responsável por realizar as querys ao Firestore e retorna o seu resultado às páginas que precisam dos dados.

- API de login: componente responsável por verificar a autenticidade de um par usuário senha e, caso o par seja autêntico, retornar as informações do usuário armazenadas no banco de dados. O componente é então uma camada que faz o uso do Firebase Authentication para prover esse serviço a página de login do app.

- Api de localização: componente responsável por fornecer serviços de localização ao app. Exemplo: busca de um endereço com base nas coordenadas geográficas e o contrário.

## Serviços externos utilizados

Serviços externos que são utilizados para o funcionamento do aplicativo:

- Firestore: Banco de dados da aplicação.

- Firebase Authentication: Sistemas de autenticação e gerenciamento de contas externas.

- Nominatim API: API do OpenStreetMap para converter endereços em coordenadas geográficas. Será usado pelo controlador de cadastro para já armazenar as coordenadas geográficas dos diferentes estabelecimentos no banco de dados e facilitar o processo de busca.


