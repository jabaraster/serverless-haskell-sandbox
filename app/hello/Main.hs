module Main where

import           AWSLambda.Events.APIGateway
import           HelloHandler

main :: IO ()
main = apiGatewayMain handler
