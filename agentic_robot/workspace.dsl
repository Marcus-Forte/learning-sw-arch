workspace "Agentic Robot" "Description" {

    !identifiers hierarchical

    model {
        u = person "User" {
            description "You"
        }

        ss = softwareSystem "LLM Robot Control" {
        llm = container "LLM" {
            description "e.g ChatGPT, Gemini"
        }

        group "Laptop" {
        mcp_client = container "MCP Client" {
            pi = component "Prompt Interface"
            sr = component "Speech Recognition"
            llm_interface = component "LLM Interface"

            llm_interface -> llm "prompts"
        }
        mcp_server = container "MCP Server" {
            sensor_client = component "gRPC Sensor Client"
            motor_client = component "gRPC Motor Client"
        }
        }

        group "Robot + Raspberry Pi" {
            grpc_sensor_server = container "gRPC Sensor Server"
            grpc_motor_server = container "gRPC Motor Server"
            !include robot.dsl
        }

        
        # mcp_client -> llm "prompts" 
        mcp_client -> mcp_server "exchange"

        mcp_server.sensor_client -> grpc_sensor_server "subscribes"
        mcp_server.motor_client -> grpc_motor_server "commands"

        grpc_sensor_server -> robot "senses"
        grpc_motor_server -> robot "controls"

        }

         u -> ss.mcp_client.pi "prompts"
    }

    views {
        
        systemContext ss "Diagram1" {
            include *
            autolayout lr
        }

        container ss "containers" {
            include *
            autolayout lr
        }

        component ss.mcp_client "MCPClient" {
            include *
            autolayout lr
        }

        component ss.mcp_server "MCPServer" {
            include *
            autolayout lr
        }

        component ss.robot "Robot" {
            include *
            # autolayout lr
        }

        styles {
            element "Element" {
                color #0773af
                stroke #0773af
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Boundary" {
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    
    }

    configuration {
        scope softwaresystem
    }

}