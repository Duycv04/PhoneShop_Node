const crypto = require('crypto');
const bcrypt = require('bcryptjs');

// Hỗ trợ đăng nhập lại bằng passwordhash của ASP.NET Identity v3.
// Format: base64 bytes [0x01][PRF][iter][saltLength][salt][subkey]
function verifyAspNetIdentityV3(password, hashedPassword) {
  try {
    const decoded = Buffer.from(hashedPassword, 'base64');
    if (decoded.length < 13 || decoded[0] !== 0x01) return false;
    const prf = decoded.readUInt32BE(1);
    const iterations = decoded.readUInt32BE(5);
    const saltLength = decoded.readUInt32BE(9);
    const salt = decoded.subarray(13, 13 + saltLength);
    const subkey = decoded.subarray(13 + saltLength);
    // ASP.NET Core Identity thường dùng HMACSHA256 cho v3.
    const digest = prf === 0 ? 'sha1' : prf === 1 ? 'sha256' : prf === 2 ? 'sha512' : 'sha256';
    const derived = crypto.pbkdf2Sync(password, salt, iterations, subkey.length, digest);
    return crypto.timingSafeEqual(derived, subkey);
  } catch {
    return false;
  }
}

async function hashPassword(password) {
  return bcrypt.hash(password, 12);
}

async function verifyPassword(password, hashedPassword) {
  if (!hashedPassword) return false;
  if (hashedPassword.startsWith('$2a$') || hashedPassword.startsWith('$2b$') || hashedPassword.startsWith('$2y$')) {
    return bcrypt.compare(password, hashedPassword);
  }
  if (verifyAspNetIdentityV3(password, hashedPassword)) return true;
  return false;
}

module.exports = { hashPassword, verifyPassword };
