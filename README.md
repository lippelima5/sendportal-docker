<h1 align="center">SendPortal Docker</h1>

Este repositório contém a versão docker do [SendPortal](https://github.com/mettle/sendportal), uma ferramenta opensource de email marketing.
Todos os arquivos relacionados ao docker são armazenados no diretório `docker`.

## Instalação

1. Certifique-se de ter o docker instalado. Verifique a documentação do docker se você não tiver: https://docs.docker.com/engine/install/
2. Crie um `.env` baseado no `.env.sample`. Ajuste o conteúdo do seu `.env` de acordo com a sua necessidade.
3. Execute o script: `./start.sh`

`O script ira criar uma imagem sendportal e depois montar um container regis e um container do sendportal, no terminal o mesmo irá parar na tela de configuração inicial do sendportal`

Depois de concluído, você pode acessar seu SendPortal em http://localhost:8181.

### Este repositorio é uma facilitação baseada nas opções abaixo:

1. [SendPortal Oficial](https://github.com/mettle/sendportal)
2. [Docker SendPortal](https://github.com/wzulfikar/docker-sendportal)


### Notas

Caso de erro no redis use o comando a seguir `docker exec -it sendportal` para acessar o container e editar o `.env` altere a linha `REDIS_HOST=` e adicione o ip do docker nele.
no meu não funcionou por domínio

Agradeço a atenção.