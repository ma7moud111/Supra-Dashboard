#include <CommonAPI/CommonAPI.hpp>
#include <v0/commonapi/examples/E01HelloWorldProxy.hpp>
#include <chrono>
#include <iostream>
#include <thread>

int main() {
    auto rt = CommonAPI::Runtime::get();

    const std::string domain = "local";
    const std::string instance = "commonapi.examples.HelloWorld";
    const std::string connection = "client-sample";

    auto proxy = rt->buildProxy<v0::commonapi::examples::E01HelloWorldProxy>(domain, instance, connection);

    while (!proxy->isAvailable())
        std::this_thread::sleep_for(std::chrono::milliseconds(10));

    CommonAPI::CallStatus st; std::string msg;

    while (true) {
        proxy->sayHello("World", st, msg);
        if (st == CommonAPI::CallStatus::SUCCESS)
            std::cout << "Client: " << msg << std::endl;
        else
            std::cerr << "Client call failed\n";
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}
