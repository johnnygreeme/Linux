#!/bin/bash

# [~] Get system information 🐳
# [~] Johnny Greeme

get_system_information() {
    (echo -e "[*] hostnamectl" && hostnamectl) || \
    (echo -e "[*] hosthame" && hosthame) || \
    (echo -e "[*] uname -n" && uname -n)
}
