namespace BlazorBlog.Data.Entities;

public class BlogPost
{
    public int Id { get; set; }
    public string Title { get; set; } = "";
    public DateTime DateCreated { get; set; }
    public DateTime? DatePublished { get; set; }
    public string Status { get; set; } = "";
    public string CoverImageUrl { get; set; } = "";
    public string UrlSlug { get; set; } = "";
    public Author Author { get; set; }
    public virtual List<Block> Blocks { get; set; } = new List<Block>();
}

public class Author
{
    public string Name { get; set; }
}

public class Block
{
    public int Id { get; set; }
    public int BlogPostId { get; set; }
    public int Order { get; set; }
    public string BlockType { get; set; } = "";
    public BlogPost BlogPost { get; set; } = null!;
}

public class HeadingBlock : Block
{
    public string Level { get; set; }
    public string Content { get; set; }
}

public class ParagraphBlock : Block
{
    public string Content { get; set; }
}

public class CodeBlock : Block
{
    public string Content { get; set; }
    public string Language { get; set; }
}

public class ImageBlock : Block
{
    public string ImageUrl { get; set; }
    public string Caption { get; set; }
    public string AltText { get; set; }
}