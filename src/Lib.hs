module Lib where

import           Data.Aeson
import           Data.Attoparsec.Text
import           Data.ByteString            (ByteString)
import qualified Data.ByteString.Char8      as BSC (unpack)
import qualified Data.ByteString.Lazy.Char8 as LBSC (pack, unpack)
import           Data.Text                  (Text)
import qualified Data.Text                  as DT (pack, unpack)

jsonToText :: (ToJSON a) => a -> Text
jsonToText = DT.pack . LBSC.unpack . encode

textToJsonParser :: FromJSON a => Parser a
textToJsonParser = do
  t <- takeText
  case decode $ LBSC.pack $ DT.unpack t of
    Just res -> return res
    Nothing  -> fail "invalid json."

byteStringToText :: ByteString -> Text
byteStringToText = DT.pack . BSC.unpack
