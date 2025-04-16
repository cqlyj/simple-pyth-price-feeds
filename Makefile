-include .env

deploy:
	@forge script script/DeployPythPriceFeed.s.sol:DeployPythPriceFeed --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

get-price-update:
	@curl -X 'GET' 'https://hermes.pyth.network/v2/updates/price/latest?ids%5B%5D=0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace' -o price_update.json

get-eth-usd-price:
	@forge script script/GetETHUSDPrice.s.sol:GetETHUSDPrice --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast -vvvv