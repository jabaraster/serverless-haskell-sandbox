{-# LANGUAGE OverloadedStrings #-}
module TestLib where

import qualified Data.HashMap.Strict as M

import           AWSLambda.Events.APIGateway

apiGatewayProxyRequest :: APIGatewayProxyRequest body
apiGatewayProxyRequest = APIGatewayProxyRequest {
      _agprqResource = ""
    , _agprqPath = ""
    , _agprqHttpMethod = "GET"
    , _agprqHeaders = []
    , _agprqQueryStringParameters = []
    , _agprqPathParameters = M.empty
    , _agprqStageVariables = M.empty
    , _agprqRequestContext = proxyRequestContext
    , _agprqBody = Nothing
    }

proxyRequestContext :: ProxyRequestContext
proxyRequestContext = ProxyRequestContext {
      _prcPath = Nothing
    , _prcAccountId = ""
    , _prcResourceId = ""
    , _prcStage = "dev"
    , _prcRequestId = ""
    , _prcIdentity = requestIdentity
    , _prcResourcePath = ""
    , _prcHttpMethod = "GET"
    , _prcApiId = ""
    , _prcProtocol = "https"
    , _prcAuthorizer = Nothing
    }

requestIdentity :: RequestIdentity
requestIdentity = RequestIdentity {
      _riCognitoIdentityPoolId = Nothing
    , _riAccountId = Nothing
    , _riCognitoIdentityId = Nothing
    , _riCaller = Nothing
    , _riApiKey = Nothing
    , _riSourceIp = Nothing
    , _riCognitoAuthenticationType = Nothing
    , _riCognitoAuthenticationProvider = Nothing
    , _riUserArn = Nothing
    , _riUserAgent = Nothing
    , _riUser = Nothing
    }
