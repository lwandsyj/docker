#!/bin/bash 
export SERVER_HOST="0.0.0.0"
export QUERY_SERVER_HOST="0.0.0.0"
export LEDGER_HOST="0.0.0.0"
./abci_validator_node.linux.gnu.dyn-linked.gnu & ./tendermint.linux.static-linked.linux node & ./query_server.linux.gnu.dyn-linked.dynlinked