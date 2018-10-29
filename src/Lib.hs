module Lib where

import           Data.Aeson
import           Data.ByteString            (ByteString)
import qualified Data.ByteString.Char8      as BSC (unpack)
import qualified Data.ByteString.Lazy.Char8 as LBSC (unpack)
import           Data.Text                  (Text)
import qualified Data.Text                  as DT (pack)

jsonToText :: (ToJSON a) => a -> Text
jsonToText = DT.pack . LBSC.unpack . encode

byteStringToText :: ByteString -> Text
byteStringToText = DT.pack . BSC.unpack
