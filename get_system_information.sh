#!/bin/bash

get_system_information() {
    (echo -e "[*] hostnamectl" && hostnamectl) || \
    (echo -e "[*] hosthame" && hosthame) || \
    (echo -e "[*] uname -n" && uname -n)
}

get_system_information
