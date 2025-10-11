#include <CommonAPI/CommonAPI.hpp>
#include <chrono>
#include <iostream>
#include <thread>
#include "E01HelloWorldStubImpl.hpp"

int main() {
    auto rt  = CommonAPI::Runtime::get();
    auto svc = std::make_shared<E01HelloWorldStubImpl>();

    const std::string domain = "local";
    const std::string instance = "commonapi.examples.HelloWorld";
    const std::string connection = "service-sample";

    if (!rt->registerService(domain, instance, svc, connection)) {
        std::cerr << "registerService failed\n";
        return 1;
    }

    std::cout << "Service ready.\n";
    while (true) std::this_thread::sleep_for(std::chrono::seconds(60));
}
