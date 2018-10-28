{-# LANGUAGE OverloadedStrings #-}
module HelloHandler where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)

handler :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse Text)
handler request = pure $ responseOK & responseBody ?~ "Hello!"
