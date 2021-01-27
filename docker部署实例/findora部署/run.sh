#!/bin/bash 
./abci_validator_node.linux.gnu.dyn-linked.gnu & ./tendermint.linux.static-linked.linux node & ./query_server.linux.gnu.dyn-linked.dynlinked
