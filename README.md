# K3L Token

K3L Token é um token ERC20 avançado implementado na rede Ethereum com recursos estendidos de governança, pausa de emergência, limite de supply, snapshots e flash mints.

## 📋 Características

### Informações Básicas
- **Nome**: K3L Token  
- **Símbolo**: K3L  
- **Decimais**: 18  
- **Padrão**: ERC20  
- **Supply**: Limitado por cap definido na implantação  

### Recursos Avançados
- ✅ **Pausável**: Transferências podem ser pausadas em emergências  
- 🎯 **Supply Limitado**: Cap máximo definido na implantação  
- 🔑 **Permit**: Suporte a aprovações sem gas (EIP-2612)  
- 🗳️ **Governança**: Sistema de votos on-chain  
- 📸 **Snapshots**: Registro do estado dos saldos  
- ⚡ **Flash Mints**: Suporte a empréstimos instantâneos  

---

## 🚀 Instalação
```bash
npm install @openzeppelin/contracts
```

---

## 📚 Uso

### Implantação
```solidity
// Deploy com supply inicial e cap máximo
const K3LToken = await ethers.getContractFactory("K3LToken");
const k3lToken = await K3LToken.deploy(initialSupply, maxCap);
await k3lToken.deployed();
```

### Funções Principais
```solidity
// Transferência básica
await k3lToken.transfer(recipient, amount);

// Aprovação de gasto
await k3lToken.approve(spender, amount);

// Mint de novos tokens (apenas owner)
await k3lToken.mint(to, amount);

// Queima de tokens
await k3lToken.burn(amount);

// Criação de snapshot (apenas owner)
await k3lToken.snapshot();

// Pausa de transferências (apenas owner)
await k3lToken.pause();

// Despausa de transferências (apenas owner)
await k3lToken.unpause();
```

---

## 🔒 Segurança

### Controles de Acesso
- **`onlyOwner`**: Funções críticas restritas ao proprietário do contrato  
- Sistema de pausas para emergências  
- Snapshots para registro de estados históricos  

### Limitações
- Supply máximo fixo  
- Proteções contra overflow/underflow (Solidity ^0.8.0)  
- Implementação segura de ERC20  

---

## 🔧 Arquitetura
O contrato herda e implementa as seguintes extensões do OpenZeppelin:

- **ERC20**
- **ERC20Pausable**
- **ERC20Capped**
- **ERC20Permit**
- **ERC20Votes**
- **ERC20Snapshot**
- **ERC20FlashMint**
- **Ownable**

---

## 🖋️ Funções do Contrato

### Administração
```solidity
function mint(address to, uint256 amount) public onlyOwner
function pause() public onlyOwner
function unpause() public onlyOwner
function snapshot() public onlyOwner returns (uint256)
```

### Usuários
```solidity
function transfer(address recipient, uint256 amount) public returns (bool)
function approve(address spender, uint256 amount) public returns (bool)
function transferFrom(address sender, address recipient, uint256 amount) public returns (bool)
function burn(uint256 amount) public
function burnFrom(address account, uint256 amount) public
```

### Visualização
```solidity
function balanceOf(address account) public view returns (uint256)
function allowance(address owner, address spender) public view returns (uint256)
function totalSupply() public view returns (uint256)
function cap() public view returns (uint256)
```

---

## 🛠️ Desenvolvimento

### Pré-requisitos
- **Node.js** >= 14.x
- **Hardhat ou Truffle**
- **OpenZeppelin Contracts**

### Testes
```bash
# Execute os testes
npm run test

# Verifique a cobertura
npm run coverage
```

---

## 📄 Licença
MIT License - veja o arquivo LICENSE.md para detalhes

---

## 👥 Contribuição

1. Fork o projeto
2. Crie sua Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

## ⚠️ Avisos Importantes

- O contrato deve ser auditado antes do uso em produção
- Funções **`onlyOwner`** devem ser utilizadas com cautela
- Mantenha backups seguros das chaves privadas do owner
- Teste extensivamente antes do deploy na mainnet

---

## 🤝 Suporte
Para suporte e dúvidas, por favor abra uma issue no repositório do GitHub.

---

## 🔄 Versão
- **Versão atual**: 1.0.0  
- **Solidity**: ^0.8.0  
- **OpenZeppelin**: Última versão estável
