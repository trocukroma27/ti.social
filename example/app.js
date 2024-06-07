import TiSocial  from 'ti.social';
Ti.API.info("module is => " + TiSocial);

const mainWindow = Ti.UI.createWindow();
const navCentralWindow = Ti.UI.createNavigationWindow({
	window: mainWindow
});
const button = Ti.UI.createButton({
	font: { fontSize: 20 },
	title: 'Share!',
	top: 80
});
button.addEventListener('click', function () {
	const file = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'file.txt');
	file.write('The file is no longer empty!');
	TiSocial.share({
		message: "Hello world!",
		file: file.nativePath
	});
});
mainWindow.add(button);
navCentralWindow.open();
