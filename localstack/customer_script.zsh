start_up() {
    docker compose up -d && sh ./setup-localstack.sh
}

shut_down() {
    docker compose down
}

restart() {
    shut_down && start_up
}

initial_docker_container() {
    get_input "📝 Please confirm that you want to initialize the container: " "n" "y/n"
    if [ "$result" != "y" ]; then
        echo -e "\n\n⚠️ Stop initial"
        return 1
    fi
    rm -rf ./volumes/localstack
}