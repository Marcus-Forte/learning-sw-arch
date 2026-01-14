workspace "Name" "Description" {

    !identifiers hierarchical

    model {
        u = person "User" {
            description "Desc"
        }

        ss = softwareSystem "LLM Robot Control" {
        llm = container "LLM" {
            description "e.g ChatGPT, Gemini"
        }
        mcp_client = container "MCP Client" {
            pi = component "Prompt Interface"
        }
        mcp_server = container "MCP Server"

        // TODO add two services: sensor, control
        grpc_server = container "gRPC Robot Server"

        // TODO need another icon
        robot = container "Robot"

        mcp_client -> llm "prompts"
        mcp_client -> mcp_server "exchange"

        mcp_server -> grpc_server "controls"

        grpc_server -> robot "controls"

        }

         u -> ss.mcp_client "Uses"
       // ss.wa -> ss.db "Reads from and writes to"
    }

    views {
    //    systemContext ss "Diagram1" {
    //       include *
    //     autolayout lr
    // }

        container ss "Diagram2" {
            include *
            autolayout lr
        }

        component ss.mcp_client "Diagram3" {
            include *
            autolayout lr
        }

       
    }

    configuration {
        scope softwaresystem
    }

}