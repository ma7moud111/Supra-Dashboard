#include "E01HelloWorldStubImpl.hpp"
#include <iostream>
#include <sstream>

void E01HelloWorldStubImpl::sayHello(const std::shared_ptr<CommonAPI::ClientId>,
                                     std::string name,
                                     sayHelloReply_t reply) {
    std::stringstream ss;
    ss << "Hello " << name << "!";
    std::cout << "sayHello('" << name << "') -> " << ss.str() << std::endl;
    reply(ss.str());
}
