package kr.ac.kopo.util;

import java.io.File;
import java.util.UUID;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class KopoFileNamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File f) {
		//확장자를 추출(ex. jpg, png, jsp 등등)
		String name = f.getName();
		String ext = "";
		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			ext = name.substring(dot); 
		} else {
			ext = "";
		}
		
		//중복성 줄이기. 이름바꿔줌
		String str = "kopo" + UUID.randomUUID();
		File renameFile = new File(f.getParent(), str + ext);
		return renameFile;
	}
}
