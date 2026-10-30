import 'dart:typed_data';

/// File header: magic 'ONV1' + 24-byte nonce, then ciphertext.
const magic = [0x4F, 0x4E, 0x56, 0x31];

/// Argon2id parameters stored in vault.json.
class KdfParams {
  final int memoryKiB;
  final int iterations;
  final Uint8List salt;
  const KdfParams({this.memoryKiB = 65536, this.iterations = 3, required this.salt});
}

/// Implemented with libsodium (sodium_libs) in M0.
abstract interface class Vault {
  /// XChaCha20-Poly1305 with the remote path as associated data.
  Uint8List seal(String path, Uint8List plaintext);
  Uint8List open(String path, Uint8List sealed);

  /// HMAC-SHA256(vaultKey, sha256(plaintext)) for blob names.
  String blobName(Uint8List plaintextSha256);
}
