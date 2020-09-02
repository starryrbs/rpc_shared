struct File{
    1: required string name,
    2: required binary buff
}

service FileService{
    bool uploadFile(1:File filedata)
}