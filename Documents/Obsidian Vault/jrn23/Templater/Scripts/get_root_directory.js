function getRootDirectory(tp) {
  const folders = tp.file.folder(true).split('/')
  const parentFolder = folders.slice(0, 1)[0].replaceAll(' ', '_');

  return parentFolder;
}

module.exports = getRootDirectory;
