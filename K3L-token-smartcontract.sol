// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importações necessárias do OpenZeppelin para funcionalidades estendidas do ERC20
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title K3LToken
 * @dev Implementação de um token ERC20 com funcionalidades avançadas incluindo:
 * - Pausável: permite pausar transferências em emergências
 * - Limitado: tem um supply máximo definido
 * - Permit: permite aprovações sem gas
 * - Votos: suporta governança on-chain
 * - Snapshot: permite capturar o estado dos saldos em momentos específicos
 * - Flash Mint: suporta empréstimos instantâneos
 */
contract K3LToken is 
    ERC20, 
    ERC20Pausable, 
    ERC20Capped, 
    ERC20Permit, 
    ERC20Snapshot, 
    ERC20Votes,
    ERC20FlashMint,
    Ownable 
{
    /**
     * @dev Constructor do contrato
     * @param initialSupply Quantidade inicial de tokens a ser mintada
     * @param cap Limite máximo de tokens que podem existir
     */
    constructor(uint256 initialSupply, uint256 cap) 
        ERC20("K3L Token", "K3L")
        ERC20Permit("K3L Token")
        ERC20Capped(cap)
    {
        _mint(msg.sender, initialSupply);
    }

    /**
     * @dev Define o número de casas decimais do token
     * @return uint8 Número de casas decimais (18 é o padrão)
     */
    function decimals() public pure override returns (uint8) {
        return 18;
    }

    /**
     * @dev Retorna o saldo de tokens de um endereço
     * @param account Endereço para verificar o saldo
     * @return uint256 Quantidade de tokens que o endereço possui
     */
    function balanceOf(address account) public view override(ERC20, IERC20) returns (uint256) {
        return super.balanceOf(account);
    }

    /**
     * @dev Transfere tokens do endereço do remetente para um destinatário
     * @param recipient Endereço que receberá os tokens
     * @param amount Quantidade de tokens a ser transferida
     * @return bool Sucesso da operação
     */
    function transfer(address recipient, uint256 amount) public override(ERC20, IERC20) returns (bool) {
        return super.transfer(recipient, amount);
    }

    /**
     * @dev Verifica quanto um spender está autorizado a gastar em nome do owner
     * @param owner Dono dos tokens
     * @param spender Endereço autorizado a gastar
     * @return uint256 Quantidade autorizada
     */
    function allowance(address owner, address spender) public view override(ERC20, IERC20) returns (uint256) {
        return super.allowance(owner, spender);
    }

    /**
     * @dev Aprova um endereço a gastar uma quantidade de tokens em nome do aprovador
     * @param spender Endereço autorizado a gastar
     * @param amount Quantidade autorizada
     * @return bool Sucesso da operação
     */
    function approve(address spender, uint256 amount) public override(ERC20, IERC20) returns (bool) {
        return super.approve(spender, amount);
    }

    /**
     * @dev Transfere tokens de um endereço para outro usando uma allowance
     * @param sender Endereço de origem dos tokens
     * @param recipient Endereço de destino dos tokens
     * @param amount Quantidade a ser transferida
     * @return bool Sucesso da operação
     */
    function transferFrom(address sender, address recipient, uint256 amount) public override(ERC20, IERC20) returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

    /**
     * @dev Aumenta a quantidade que um spender pode gastar
     * @param spender Endereço autorizado
     * @param addedValue Valor adicional a ser autorizado
     * @return bool Sucesso da operação
     */
    function increaseAllowance(address spender, uint256 addedValue) public override returns (bool) {
        return super.increaseAllowance(spender, addedValue);
    }

    /**
     * @dev Diminui a quantidade que um spender pode gastar
     * @param spender Endereço autorizado
     * @param subtractedValue Valor a ser reduzido da autorização
     * @return bool Sucesso da operação
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public override returns (bool) {
        return super.decreaseAllowance(spender, subtractedValue);
    }

    /**
     * @dev Retorna o supply total de tokens
     * @return uint256 Quantidade total de tokens em existência
     */
    function totalSupply() public view override(ERC20, IERC20) returns (uint256) {
        return super.totalSupply();
    }

    /**
     * @dev Cria novos tokens e os atribui a um endereço
     * @param to Endereço que receberá os novos tokens
     * @param amount Quantidade de tokens a ser criada
     * Somente o owner pode chamar esta função
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Queima (destrói) tokens do endereço que chamou a função
     * @param amount Quantidade de tokens a ser queimada
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Queima tokens de um endereço específico (requer allowance)
     * @param account Endereço dos tokens a serem queimados
     * @param amount Quantidade a ser queimada
     */
    function burnFrom(address account, uint256 amount) public {
        uint256 currentAllowance = allowance(account, msg.sender);
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        _approve(account, msg.sender, currentAllowance - amount);
        _burn(account, amount);
    }

    /**
     * @dev Pausa todas as transferências de token
     * Somente o owner pode pausar
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Despausa as transferências de token
     * Somente o owner pode despausar
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Cria um snapshot do estado atual dos saldos
     * @return uint256 ID do snapshot criado
     * Somente o owner pode criar snapshots
     */
    function snapshot() public onlyOwner returns (uint256) {
        return _snapshot();
    }

    /**
     * @dev Retorna o limite máximo de tokens que podem ser criados
     * @return uint256 Quantidade máxima de tokens
     */
    function cap() public view override returns (uint256) {
        return super.cap();
    }

    /**
     * @dev Hook executado antes de qualquer transferência de tokens
     * Combina as verificações de Pausable, Snapshot e Votes
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable, ERC20Snapshot, ERC20Votes) {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev Hook executado após qualquer transferência de tokens
     * Atualiza os registros de votação
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    /**
     * @dev Função interna de mint que respeita o cap e atualiza os votos
     */
    function _mint(address to, uint256 amount) internal override(ERC20, ERC20Capped, ERC20Votes) {
        super._mint(to, amount);
    }

    /**
     * @dev Função interna de burn que atualiza os registros de votação
     */
    function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }
}
