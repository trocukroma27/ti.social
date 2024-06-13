import TiSocial  from 'ti.social';
Ti.API.info("module is => " + TiSocial);

const mainWindow = Ti.UI.createWindow();
const navCentralWindow = Ti.UI.createNavigationWindow({
	window: mainWindow
});
const button1 = Ti.UI.createButton({
	font: { fontSize: 20 },
	title: 'Share',
	top: 80
});
button1.addEventListener('click', function () {
	const file = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'file.txt');
	file.write('The file is no longer empty!');
	TiSocial.share({
		message: "Hello world!",
		file: file.nativePath,
		callback: function(data) {
			console.log(data);
		},
	});
});
mainWindow.add(button1);
const button2 = Ti.UI.createButton({
	font: { fontSize: 20 },
	title: 'Share empty',
	top: 160
});
button2.addEventListener('click', function () {
	TiSocial.share({
		callback: function(data) {
			console.log(data);
		},
	});
});
mainWindow.add(button2);
navCentralWindow.open();
