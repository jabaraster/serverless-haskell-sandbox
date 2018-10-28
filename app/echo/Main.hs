module Main where

import           AWSLambda.Events.APIGateway
import           EchoHandler

main :: IO ()
main = apiGatewayMain handler
