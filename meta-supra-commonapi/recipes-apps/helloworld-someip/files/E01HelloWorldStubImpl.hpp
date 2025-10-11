#pragma once
#include <memory>
#include <string>
#include <v0/commonapi/examples/E01HelloWorldStub.hpp>

class E01HelloWorldStubImpl : public v0::commonapi::examples::E01HelloWorldStub {
public:
    E01HelloWorldStubImpl() = default;
    ~E01HelloWorldStubImpl() override = default;

    // Implement the pure virtual from the generated skeleton
    void sayHello(const std::shared_ptr<CommonAPI::ClientId> _client,
                  std::string _name,
                  sayHelloReply_t _reply) override;
};
