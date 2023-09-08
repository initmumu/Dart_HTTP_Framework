import 'dart:io';

staticFileTransferHandler(req, res, File staticFile) {
  res.sendFile('Static', staticFile: staticFile);
}
