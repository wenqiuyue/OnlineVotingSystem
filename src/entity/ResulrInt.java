package entity;

public class ResulrInt {
	private int flag;  //标识
	private int content;   //返回的内容
	public ResulrInt(int flag,int content) {
		this.flag=flag;
		this.content=content;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public int getContent() {
		return content;
	}
	public void setContent(int content) {
		this.content = content;
	}
	
	
}
